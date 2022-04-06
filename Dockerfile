FROM ubuntu:20.04

# install java 8
RUN apt-get update \
  && apt-get install -y software-properties-common \
  && add-apt-repository ppa:openjdk-r/ppa \
  && apt-get update \
  && apt-get install -y openjdk-8-jre wget

# working directory for minecraft
RUN mkdir /opt/minecraft

# fetch minecraft forge version 1.12.2 jar
RUN wget -O /opt/minecraft/minecraft-forge-installer.jar https://files.minecraftforge.net/maven/net/minecraftforge/forge/1.12.2-14.23.5.2860/forge-1.12.2-14.23.5.2860-installer.jar 

# install minecraft server
RUN cd /opt/minecraft \
  && java -Xms3324M -Xmx4000M -jar /opt/minecraft/minecraft-forge-installer.jar --installServer

# accept the eula
RUN echo "eula=true" >> /opt/minecraft/eula.txt

# rename minecraft forge universal jar
RUN mv /opt/minecraft/forge-1.12.2-14.23.5.2860-universal.jar /opt/minecraft/minecraft-forge.jar

# install mods
RUN mkdir /opt/minecraft/mods \
  && mkdir /opt/minecraft/mods-available \
  && wget -O Pixelmon-1.12.2-8.3.8.jar https://dl.reforged.gg/3JCUH41 \ 
  && wget --user-agent Mozilla/4.0 -O /opt/minecraft/mods-available/PixelExtras.jar https://pixelmonmod.com/mirror/sidemods/PixelmonExtras/2.5.17/PixelExtras-1.12.2-2.5.17-universal.jar \
  && wget -O /opt/minecraft/mods-available/jei.jar https://media.forgecdn.net/files/3043/174/jei_1.12.2-4.16.1.302.jar  


# cleanup
RUN rm /opt/minecraft/minecraft-forge-installer.jar

COPY server.sh /opt/minecraft

EXPOSE 25565

WORKDIR /opt/minecraft

CMD [ "/bin/bash", "/opt/minecraft/server.sh" ]