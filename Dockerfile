# Usa la imagen base de .NET SDK para construir la aplicación
FROM mcr.microsoft.com/dotnet/sdk:8.0 AS build

# Establece el directorio de trabajo
WORKDIR /src

# Copia el archivo .csproj y restaura las dependencias
COPY ["CourseApi.csproj", "./"]
RUN dotnet restore "CourseApi.csproj"

# Copia los archivos y compila la aplicación
COPY . .
RUN dotnet publish "CourseApi.csproj" -c Release -o /app/publish

# Usa la imagen base de ASP.NET Core Runtime para ejecutar la aplicación
FROM mcr.microsoft.com/dotnet/aspnet:8.0 AS base

WORKDIR /app
EXPOSE 80

# Copia los archivos compilados al contenedor
COPY --from=build /app/publish .

# Ejecuta la aplicación
ENTRYPOINT ["dotnet", "CourseApi.dll"]

