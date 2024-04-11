using Microsoft.EntityFrameworkCore.Migrations;

#nullable disable

namespace AniMATE_Api.Migrations
{
    /// <inheritdoc />
    public partial class ModifiedPet : Migration
    {
        /// <inheritdoc />
        protected override void Up(MigrationBuilder migrationBuilder)
        {
            migrationBuilder.DropForeignKey(
                name: "FK_Pet_AspNetUsers_UserId",
                table: "Pet");

            migrationBuilder.DropIndex(
                name: "IX_Pet_UserId",
                table: "Pet");

            migrationBuilder.DropColumn(
                name: "UserId",
                table: "Pet");

            migrationBuilder.AddColumn<string>(
                name: "OwnerId",
                table: "Pet",
                type: "TEXT",
                nullable: false,
                defaultValue: "");

            migrationBuilder.CreateIndex(
                name: "IX_Pet_OwnerId",
                table: "Pet",
                column: "OwnerId");

            migrationBuilder.AddForeignKey(
                name: "FK_Pet_AspNetUsers_OwnerId",
                table: "Pet",
                column: "OwnerId",
                principalTable: "AspNetUsers",
                principalColumn: "Id",
                onDelete: ReferentialAction.Cascade);
        }

        /// <inheritdoc />
        protected override void Down(MigrationBuilder migrationBuilder)
        {
            migrationBuilder.DropForeignKey(
                name: "FK_Pet_AspNetUsers_OwnerId",
                table: "Pet");

            migrationBuilder.DropIndex(
                name: "IX_Pet_OwnerId",
                table: "Pet");

            migrationBuilder.DropColumn(
                name: "OwnerId",
                table: "Pet");

            migrationBuilder.AddColumn<string>(
                name: "UserId",
                table: "Pet",
                type: "TEXT",
                nullable: true);

            migrationBuilder.CreateIndex(
                name: "IX_Pet_UserId",
                table: "Pet",
                column: "UserId");

            migrationBuilder.AddForeignKey(
                name: "FK_Pet_AspNetUsers_UserId",
                table: "Pet",
                column: "UserId",
                principalTable: "AspNetUsers",
                principalColumn: "Id");
        }
    }
}
