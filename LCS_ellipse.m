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

    % 创建一个新的图像来绘制椭圆
    fig = figure('Visible', 'off');  % 创建不可见的图像
    imshow(I);
    hold on;
    drawEllipses(ellipses', I, 'g');  % 传递 'g' 参数来指定绿色
    title(['Detected Ellipses: ', num2str(size(ellipses,1))]);

    % 保存图像
    saveas(fig, 'detected_ellipses.png');
    print(fig, 'detected_ellipses_highres.png', '-dpng', '-r300');  % 保存高分辨率图像
    close(fig);

    % 显示检测到的椭圆数量
    ellipses(:,5) = ellipses(:,5)./pi*180;
    disp(['The total number of detected ellipses: ', num2str(size(ellipses,1))]);

    % 将椭圆参数写入文本文件
    writematrix(ellipses, 'ellipses_parameters.txt', 'Delimiter', 'tab');

    disp('处理完成。检查当前目录中的 detected_ellipses.png 和 detected_ellipses_highres.png 文件以查看结果。');
end
