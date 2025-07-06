cd /opt/nexus
sudo mkdir -p ./nexus-data
sudo chown -R 200 ./nexus-data

docker run -d -p 8081:8081 --name nexus -v /opt/nexus/nexus-data:/nexus-data sonatype/nexus3
