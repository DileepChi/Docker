#See https://aka.ms/containerfastmode to understand how Visual Studio uses this Dockerfile to build your images for faster debugging.

FROM mcr.microsoft.com/dotnet/aspnet:3.1 AS base
WORKDIR /app
EXPOSE 80

FROM mcr.microsoft.com/dotnet/sdk:3.1 AS build
WORKDIR /src
COPY ["Docker4.csproj", ""]
RUN dotnet restore "Docker4.csproj"
COPY . .
WORKDIR "/src/."
RUN dotnet build "Docker4.csproj" -c Release -o /app/build

FROM build AS publish
RUN dotnet publish "Docker4.csproj" -c Release -o /app/publish

FROM base AS final
WORKDIR /app
COPY --from=publish /app/publish .
ENTRYPOINT ["dotnet", "Docker4.dll"]