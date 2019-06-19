FROM mcr.microsoft.com/dotnet/core/sdk:2.2 AS build

ENV NUGET_XMLDOC_MODE skip
WORKDIR /vsdbg
RUN apt-get update \
    && apt-get install -y --no-install-recommends \
       unzip \
    && rm -rf /var/lib/apt/lists/* \
    && curl -sSL https://aka.ms/getvsdbgsh | bash /dev/stdin -v latest -l /vsdbg

COPY ./src/ /app

WORKDIR /app

RUN dotnet restore
RUN dotnet publish --output output --configuration Debug

ENTRYPOINT ["/bin/bash", "-c", "sleep infinity"]