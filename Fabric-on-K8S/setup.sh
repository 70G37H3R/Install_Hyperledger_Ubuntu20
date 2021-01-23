################################
#DO NOT RUN THIS SCRIPT AS ROOT#
################################
sudo apt update
sudo apt install python3 -y
bash -s -- 1.1.0 bootstrap.sh
mv ./fabric-samples/bin ./
chmod a+x setupCluster/generateAll.sh
./setupCluster/generateAll.sh
python3 setupCluster/transform/run.py
