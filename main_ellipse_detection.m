function [] = main_ellipse_detection(folder_path)
    % 确保文件夹路径以文件分隔符结尾
    if ~strcmp(folder_path(end), filesep)
        folder_path = [folder_path filesep];
    end

    % 获取文件夹中的所有图片文件
    image_files = dir(fullfile(folder_path, '*.jpg'));  % 假设图片是jpg格式，可以根据需要添加其他格式
    image_files = [image_files; dir(fullfile(folder_path, '*.png'))];

    % 处理每个图片文件
    for i = 1:length(image_files)
        file_name = image_files(i).name;
        file_path = fullfile(folder_path, file_name);
        
        % 构造输出文件名
        [~, name, ext] = fileparts(file_name);
        output_name = ['Lu_' name];
        
        % 运行椭圆检测
        LCS_ellipse(file_path, folder_path, output_name);
        
        disp(['Processed file: ' file_name]);
    end

    disp('All files processed.');
end
