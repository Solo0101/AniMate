FROM mcr.microsoft.com/dotnet/aspnet:8.0 AS base
USER $APP_UID
WORKDIR /app
EXPOSE 8080
#EXPOSE 8081

FROM mcr.microsoft.com/dotnet/sdk:8.0 AS build
ARG BUILD_CONFIGURATION=Release
WORKDIR /app
COPY ["AniMATE_Api/AniMATE_Api.csproj", "AniMATE_Api/"]
RUN dotnet restore "AniMATE_Api/AniMATE_Api.csproj"
COPY . .
WORKDIR "/app/."
RUN dotnet build "AniMATE_Api.csproj" -c $BUILD_CONFIGURATION -o /app/build

FROM build AS publish
ARG BUILD_CONFIGURATION=Release
RUN dotnet publish "AniMATE_Api.csproj" -c $BUILD_CONFIGURATION -o /app/publish /p:UseAppHost=false

FROM base AS final
WORKDIR /app
COPY --from=publish /app/publish .
ENTRYPOINT ["dotnet", "AniMATE_Api.dll"]
#/app/AniMATE_Api/bin/Release/net8.0/AniMATE_Api.dll