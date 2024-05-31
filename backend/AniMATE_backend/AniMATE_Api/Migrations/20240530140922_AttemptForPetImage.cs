﻿using Microsoft.EntityFrameworkCore.Migrations;

#nullable disable

namespace AniMATE_Api.Migrations
{
    /// <inheritdoc />
    public partial class AttemptForPetImage : Migration
    {
        /// <inheritdoc />
        protected override void Up(MigrationBuilder migrationBuilder)
        {
            migrationBuilder.DropColumn(
                name: "Image",
                table: "Pets");
        }

        /// <inheritdoc />
        protected override void Down(MigrationBuilder migrationBuilder)
        {
            migrationBuilder.AddColumn<string>(
                name: "Image",
                table: "Pets",
                type: "TEXT",
                maxLength: 1024,
                nullable: false,
                defaultValue: "");
        }
    }
}