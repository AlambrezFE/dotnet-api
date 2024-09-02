FROM mcr.microsoft.com/dotnet/sdk:8.0 AS build

WORKDIR /src


RUN dotnet new webapi -n CourseApi

COPY appsettings.json /src/CourseApi/appsettings.json

COPY Controllers /src/CourseApi/

WORKDIR /src/CourseApi

RUN dotnet restore

RUN dotnet publish -c Release -o /app/publish

FROM mcr.microsoft.com/dotnet/aspnet:8.0 AS base

WORKDIR /app
EXPOSE 80

COPY --from=build /app/publish .

ENTRYPOINT ["dotnet", "CourseApi.dll"]

