FROM debian:10.1

LABEL "version"="0.0.7"
LABEL "com.github.actions.name"="Bump version using kts"
LABEL "com.github.actions.description"="Bump version on Github using kts"
LABEL "com.github.actions.icon"="package"
LABEL "com.github.actions.color"="red"

LABEL "repository"="https://github.com/VladDaniliuk/action-bump_version"
LABEL "maintainer"="VladDaniliuk"

RUN apt update \
	&& apt -y upgrade \
	&& apt install -y hub \
	&& apt autoremove \
	&& apt autoclean \
	&& apt clean

ADD entrypoint.sh /entrypoint.sh
RUN chmod +x /entrypoint.sh
ENTRYPOINT ["/entrypoint.sh"]
