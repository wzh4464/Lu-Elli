function []  = LCS_ellipse()
%% parameters illustration
%1) Tac: 
%The threshold of elliptic angular coverage which ranges from 0~360. 
%The higher Tac, the more complete the detected ellipse should be.
%2) Tr:
%The ratio of support inliers to ellipse which ranges from 0~1.
%The higher Tr, the more sufficient the support inliers are.
%3) specified_polarity: 
%1 means detecting the ellipses with positive polarity;
%-1 means detecting the ellipses with negative polarity; 
%0 means detecting all ellipses from image


close all;

%image path
filename = '/home/zihan/dataset/Media/codes/elli-compare/Lu-Elli/pics/666.jpg';


% 参数设置
Tac = 165;
Tr = 0.6;
specified_polarity = 0;

% 读取图像
disp('------read image------');
I = imread(filename);

% 检测椭圆
[ellipses, ~, posi] = ellipseDetectionByArcSupportLSs(I, Tac, Tr, specified_polarity);

% 保存检测结果到文件
save('ellipses_result.mat', 'ellipses', 'posi');

% 将检测到的椭圆绘制到图像上并保存
fig = figure('Visible', 'off');
imshow(I);
hold on;
drawEllipses(ellipses', I);
saveas(fig, 'detected_ellipses.png');
close(fig);

% 显示检测到的椭圆数量
ellipses(:,5) = ellipses(:,5)./pi*180;
disp(['The total number of detected ellipses: ', num2str(size(ellipses,1))]);

% 可选：将椭圆参数写入文本文件
writematrix(ellipses, 'ellipses_parameters.txt', 'Delimiter', 'tab');
end


