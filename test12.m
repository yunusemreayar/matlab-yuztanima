load('gTruthAcf.mat');
load('Detector.mat');
redBuoyGTruth = selectLabels(gTruthAcf,'emre');

resim=imread('C:\Users\YazilimLab\Desktop\yunus emre ayar 16008116017\mytest\IMG-20200514-WA0404.jpg');
A=imresize(resim,[1024,768]);

trainingData = objectDetectorTrainingData(redBuoyGTruth,'SamplingFactor',1,...
'WriteLocation','TrainingData');
detector = trainACFObjectDetector(trainingData,'NumStages',5);
save('Detector.mat','detector');
i = 2;
results = struct('Boxes',[],'Scores',[]);
  [BBOX, scores] = detect(detector,A,'Threshold',1);
  
    [~,idx] = max(scores);
    results(i).Boxes = BBOX;
    results(i).Scores = scores;
    
    annotation = sprintf('%s , Confidence %4.2f',detector.ModelName,scores(idx));
    I = insertObjectAnnotation(A,'rectangle',BBOX(idx,:),annotation,'TextBoxOpacity',0.8,'FontSize',30);
       
  figure, imshow(I)