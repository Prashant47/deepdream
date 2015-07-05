# Installation is for Ubuntu 12.04

export PYTHONPATH=/path/to/caffe/python
export PATH=$PATH:/path/to/caffe/.build_release/tools

# General dependencies
sudo apt-get install libprotobuf-dev libleveldb-dev libsnappy-dev libopencv-dev libboost-all-dev libhdf5-serial-dev

#Manual installation dependencies 

# installing glog
wget https://google-glog.googlecode.com/files/glog-0.3.3.tar.gz
tar zxvf glog-0.3.3.tar.gz
cd glog-0.3.3
./configure
make && make install

# installing gflags
wget https://github.com/schuhschuh/gflags/archive/master.zip
unzip master.zip
cd gflags-master
mkdir build && cd build
export CXXFLAGS="-fPIC" && cmake .. && make VERBOSE=1
make && make install

# installing lmdb
git clone https://gitorious.org/mdb/mdb.git
cd mdb/libraries/liblmdb
make && make install

# clone the caffe git repo
git clone https://github.com/BVLC/caffe.git


# Build Caffe core
cd caffe
cp Makefile.config.example Makefile.config && \
echo "CPU_ONLY := 1" >> Makefile.config && \
make all


#Install python dependency
cd caffe &&
pip install -r python/requirements.txt


# Build Caffe python bindings
cd caffe && make pycaffe

#Download GoogLeNet
caffe/scripts/download_model_binary.py /opt/caffe/models/bvlc_googlenet
