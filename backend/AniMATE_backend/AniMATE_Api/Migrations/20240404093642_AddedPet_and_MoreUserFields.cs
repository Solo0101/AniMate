using Microsoft.EntityFrameworkCore.Migrations;

#nullable disable

namespace AniMATE_Api.Migrations
{
    /// <inheritdoc />
    public partial class AddedPet_and_MoreUserFields : Migration
    {
        /// <inheritdoc />
        protected override void Up(MigrationBuilder migrationBuilder)
        {
            migrationBuilder.AddColumn<string>(
                name: "Description",
                table: "Pet",
                type: "TEXT",
                nullable: false,
                defaultValue: "");
        }

        /// <inheritdoc />
        protected override void Down(MigrationBuilder migrationBuilder)
        {
            migrationBuilder.DropColumn(
                name: "Description",
                table: "Pet");
        }
    }
}
