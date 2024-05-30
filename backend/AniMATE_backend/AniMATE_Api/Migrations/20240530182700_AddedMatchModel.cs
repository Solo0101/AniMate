using Microsoft.EntityFrameworkCore.Migrations;

#nullable disable

namespace AniMATE_Api.Migrations
{
    /// <inheritdoc />
    public partial class AddedMatchModel : Migration
    {
        /// <inheritdoc />
        protected override void Up(MigrationBuilder migrationBuilder)
        {
            migrationBuilder.CreateTable(
                name: "Matches",
                columns: table => new
                {
                    Id = table.Column<string>(type: "TEXT", maxLength: 1024, nullable: false),
                    PetId = table.Column<string>(type: "TEXT", maxLength: 1024, nullable: false),
                    MatchedPetId = table.Column<string>(type: "TEXT", maxLength: 1024, nullable: false)
                },
                constraints: table =>
                {
                    table.PrimaryKey("PK_Matches", x => x.Id);
                });
        }

        /// <inheritdoc />
        protected override void Down(MigrationBuilder migrationBuilder)
        {
            migrationBuilder.DropTable(
                name: "Matches");
        }
    }
}
