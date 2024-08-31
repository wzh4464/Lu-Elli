% Usage: plot_ellipses(Ellipses,size_im,fig_handle);
%
% Inputs: 
% Ellipses - parameters of the detected ellipses. Each coloumn contains
%                 [ x0 - x coordinate of the center of the ellipse
%                   y0 - y coordinate of the center of the ellipse
%                   a - length of semimajor axis
%                   b - length of semiminor axis
%                   alpha - angle of orientation of semimajor axis]
% size_im - size(im) where im is the gray image
% color - color of the ellipses ('r' for red, 'g' for green, 'b' for blue)
%
% This function plots the ellipses
%
% Copyright (c) 2012 Dilip K. Prasad
% School of Computer Engineering
% Nanyang Technological University, Singapore
% http://www.ntu.edu.sg/


function [] = drawEllipses(ellipses_para, im, color)
    if nargin < 3
        color = 'r';  % 默认颜色为红色
    end
    
    if ~isempty(im)
        hold on;
    else
        error('No image provided for drawEllipses function.');
    end
    
    th = 0:pi/180:2*pi;
    for i = 1:size(ellipses_para, 2)
        Semi_major = ellipses_para(3, i);
        Semi_minor = ellipses_para(4, i);
        x0 = ellipses_para(1, i);
        y0 = ellipses_para(2, i);
        Phi = ellipses_para(5, i);
        x = x0 + Semi_major * cos(Phi) * cos(th) - Semi_minor * sin(Phi) * sin(th);
        y = y0 + Semi_minor * cos(Phi) * sin(th) + Semi_major * sin(Phi) * cos(th);   
        
        plot(x, y, color, 'LineWidth', 2);  % 使用传入的颜色参数
    end
    
    axis on; 
    set(gca, 'XTick', [], 'YTick', []);
    axis ij; 
    axis equal; 
    axis([0 size(im, 2) 0 size(im, 1)]);
end
