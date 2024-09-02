FROM mcr.microsoft.com/dotnet/sdk:8.0 AS build

WORKDIR /src


RUN dotnet new webapi -n back-net2

COPY appsettings.json /src/back-net2/appsettings.json

COPY Controllers /src/back-net2/

COPY Program.cs /src/back-net2/Program.cs

WORKDIR /src/back-net2

RUN dotnet restore

RUN dotnet publish -c Release -o /app/publish

FROM mcr.microsoft.com/dotnet/aspnet:8.0 AS base

WORKDIR /app
EXPOSE 8080

COPY --from=build /app/publish .

ENTRYPOINT ["dotnet", "CourseApi.dll"]

