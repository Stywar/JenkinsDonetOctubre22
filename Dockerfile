FROM mcr.microsoft.com/dotnet/sdk:6.0 AS build
WORKDIR /app
COPY . ./
RUN dotnet restore

COPY . ./
RUN dotnet publish ProjectTest.API -c release -o out

FROM mcr.microsoft.com/dotnet/aspnet:6.0 AS base
WORKDIR /app
COPY --from=build /app/out .
ENV ASPNETCORE_URLS http://*:8080
ENV DOTNET_RUNNING_IN_CONTAINER true
EXPOSE 8080
ENTRYPOINT ["dotnet", "ProjectTest.API.dll"]