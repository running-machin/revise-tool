# source /workspace/persistent/biasenv/bin/activate
# step 1:colne the repo
# git clone https://github.com/princetonvisualai/revise-tool
git clone https://github.com/running-machin/revise-tool.git
apt-get update
# apt-get install -y subversion
''' if the there is no conda just install miniconda or something if not try to install the dependencies manually 
with pip while running the script'''

cd revise-tool/
# step 2: download the pretrained models
bash download.sh

# apparently the amazon's recognition is used to detect the videos. but i have to yet

# step 3: downlaod the datasets
# in this case i going with the COCO recomended by the revise tool

# if not install the gdown package
# pip install gdown

mkdir results
mkdir results/coco_example
# sample coco data in results/coco_example  
gdown --folder https://drive.google.com/drive/folders/1cGUr2ruV7IRl4h8EGtCjRCsg8wtPVu5P?usp=sharing -O results/coco_example

# make a directocy Data/COCO/
mkdir Data
mkdir Data/Coco
mkdir Data/Coco/2014data
mkdir Data/Coco/2014data/bias_splits
# download the dataset
wget http://images.cocodataset.org/zips/train2014.zip -O Data/Coco/train2014.zip
wget http://images.cocodataset.org/annotations/annotations_trainval2014.zip -O Data/Coco/annotations_trainval2014.zip

# unzip
unzip Data/Coco/train2014.zip -d Data/Coco/2014data/
unzip Data/Coco/annotations_trainval2014.zip -d Data/Coco/2014data/
# rm Data/Coco/train2014.zip
# rm Data/Coco/annotations_trainval2014.zip

wget https://raw.githubusercontent.com/uclanlp/reducingbias/master/data/COCO/train.data -O Data/Coco/2014data/bias_splits/train.data
wget https://raw.githubusercontent.com/uclanlp/reducingbias/master/data/COCO/test.data -O Data/Coco/2014data/bias_splits/test.data
wget https://raw.githubusercontent.com/uclanlp/reducingbias/master/data/COCO/dev.data -O Data/Coco/2014data/bias_splits/dev.data
wget https://raw.githubusercontent.com/uclanlp/reducingbias/master/data/COCO/potentials_dev -O Data/Coco/2014data/bias_splits/potentials_dev
wget https://raw.githubusercontent.com/uclanlp/reducingbias/master/data/COCO/potentials_test -O Data/Coco/2014data/bias_splits/potentials_test
wget https://raw.githubusercontent.com/uclanlp/reducingbias/master/data/COCO/objs -O Data/Coco/2014data/bias_splits/objs
# svn checkout https://github.com/uclanlp/reducingbias/trunk/data/COCO  Data/Coco/2014data/bias_splits/

# need to add the correct directory to the dataset.py as per the template

# now to check the dataloader
python3 tester_script.py CoCoDataset

# measure the data (done until here couldnt follow up later due to GPU issue)

# i am using analysis notebook to see what happens
# datasets.py importing gets issue with datasets package so rename the py file to revive_datasets
# AttributeError: module 'os' has no attribute 'mkdirs' use os.makedirs

# took a break, now i am looking into running 
python3 measurements/prerun_analyzeattr.py --dataset 'coco' --folder 'coco_example'
# Make sure the categories_places365 is in the correct folder