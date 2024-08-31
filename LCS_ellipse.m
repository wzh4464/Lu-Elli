function [] = LCS_ellipse(input_file, output_folder, output_name)
    %% LCS_ellipse: 椭圆检测
    % 输入参数:
    %     input_file: 输入图像文件路径
    %     output_folder: 输出文件夹路径
    %     output_name: 输出文件名
    % 输出参数:
    %     无
    % 保存结果:
    %     1. [output_name '_result.mat']: 检测结果
    %     2. [output_name '.png']: 检测结果图像
    %     3. [output_name '_highres.png']: 高分辨率检测结果图像
    %     4. [output_name '_parameters.txt']: 椭圆参数
    % 示例:
    %     LCS_ellipse('input.png', 'output', 'output');

    % 参数设置
    Tac = 165;
    Tr = 0.6;
    specified_polarity = 0;
    
    % 读取图像
    disp(['Processing image: ' input_file]);
    I = imread(input_file);
    
    % 检测椭圆
    [ellipses, ~, posi] = ellipseDetectionByArcSupportLSs(I, Tac, Tr, specified_polarity);
    
    % 保存检测结果到文件
    save(fullfile(output_folder, [output_name '_result.mat']), 'ellipses', 'posi');
    
    % 创建一个新的图像来绘制椭圆
    fig = figure('Visible', 'off');  % 创建不可见的图像
    imshow(I);
    hold on;
    drawEllipses(ellipses', I, 'g');  % 使用绿色绘制椭圆
    title(['Detected Ellipses: ', num2str(size(ellipses,1))]);
    
    % 保存图像
    saveas(fig, fullfile(output_folder, [output_name '.png']));
    print(fig, fullfile(output_folder, [output_name '_highres.png']), '-dpng', '-r300');  % 保存高分辨率图像
    close(fig);
    
    % 显示检测到的椭圆数量
    ellipses(:,5) = ellipses(:,5)./pi*180;
    disp(['The total number of detected ellipses: ', num2str(size(ellipses,1))]);
    
    % 将椭圆参数写入文本文件
    writematrix(ellipses, fullfile(output_folder, [output_name '_parameters.txt']), 'Delimiter', 'tab');
end
