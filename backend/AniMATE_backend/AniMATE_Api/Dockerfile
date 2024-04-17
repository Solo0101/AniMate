FROM mcr.microsoft.com/dotnet/aspnet:8.0 AS base
USER $APP_UID
WORKDIR /app
EXPOSE 8080
#EXPOSE 8081

FROM mcr.microsoft.com/dotnet/sdk:8.0 AS build
ARG BUILD_CONFIGURATION=Development
WORKDIR /app
COPY ["AniMATE_Api/AniMATE_Api.csproj", "AniMATE_Api/"]
RUN dotnet restore "AniMATE_Api/AniMATE_Api.csproj"
COPY . .

WORKDIR /app/AniMATE_Api/
RUN dotnet build "AniMATE_Api.csproj" -c $BUILD_CONFIGURATION -o /app/build
RUN dotnet tool install --global dotnet-ef --version 8.* --add-source https://pkgs.dev.azure.com/dnceng/public/_packaging/dotnet-eng/nuget/v3/index.json
ENV PATH="${PATH}:/root/.dotnet/tools"
RUN dotnet ef database update

FROM build AS publish
ARG BUILD_CONFIGURATION=Development
RUN dotnet publish "AniMATE_Api.csproj" -c $BUILD_CONFIGURATION -o /app/publish

FROM base AS final
WORKDIR /app
COPY --from=publish /app/publish .
ENTRYPOINT ["dotnet", "/app/AniMATE_Api.dll"]
#/app/AniMATE_Api/bin/Release/net8.0/AniMATE_Api.dll