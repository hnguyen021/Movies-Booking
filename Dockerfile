FROM mcr.microsoft.com/dotnet/aspnet:5.0 AS base
EXPOSE 80
WORKDIR /app

FROM mcr.microsoft.com/dotnet/sdk:5.0 AS build
WORKDIR /src
COPY ["CinemaWorld.csproj", "."]
RUN dotnet restore "CinemaWorld.csproj"
COPY . .
WORKDIR "/src/"
RUN dotnet build "CinemaWorld.csproj" -c Release -o /app/build

FROM build AS publish
RUN dotnet publish "CinemaWorld.csproj" -c Release -o /app/publish

FROM base AS final
WORKDIR /app
COPY --from=publish /app/publish .
ENTRYPOINT ["dotnet", "CinemaWorld.dll"]