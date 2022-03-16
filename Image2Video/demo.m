clc; clear; close all;
addpath('function');

fileName = 'BraTS2021_00000';
dir = fullfile('data', 'BraTS2021_00000');
flair = niftiread(fullfile(dir, [fileName '_flair.nii.gz']));
t1    = niftiread(fullfile(dir, [fileName '_t1.nii.gz']));
t1ce  = niftiread(fullfile(dir, [fileName '_t1ce.nii.gz']));
t2    = niftiread(fullfile(dir, [fileName '_t2.nii.gz']));
label = niftiread(fullfile(dir, [fileName '_seg.nii.gz']));

flair = ImgProcess(flair);
t1    = ImgProcess(t1);
t1ce  = ImgProcess(t1ce);
t2    = ImgProcess(t2);

flairLab = Overlay(flair, label, [1, 0, 1], 0.5);
t1Lab    = Overlay(t1, label, [1, 0, 1], 0.5);
t1ceLab  = Overlay(t1ce, label, [1, 0, 1], 0.5);
t2Lab    = Overlay(t2, label, [1, 0, 1], 0.5);

WriteVideo([flair, t1, t1ce, t2; flairLab, t1Lab, t1ceLab, t2Lab], [fileName '.avi']);
