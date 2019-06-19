FROM mcr.microsoft.com/dotnet/core/sdk:2.2 AS build
WORKDIR /

COPY ./src/ .

RUN dotnet restore

RUN dotnet publish --output /output --configuration Release

FROM mcr.microsoft.com/dotnet/core/aspnet:2.2 as runtime

COPY --from=build /output /app

WORKDIR /app  
ENTRYPOINT ["dotnet", "dockerdemo.dll"]