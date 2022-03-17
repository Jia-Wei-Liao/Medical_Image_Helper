clc; clear; close all;

fileName = 'BraTS2021_00000';
dir = fullfile('data', 'BraTS2021_00000');
flair = niftiread(fullfile(dir, [fileName '_flair.nii.gz']));
t1    = niftiread(fullfile(dir, [fileName '_t1.nii.gz']));
t1ce  = niftiread(fullfile(dir, [fileName '_t1ce.nii.gz']));
t2    = niftiread(fullfile(dir, [fileName '_t2.nii.gz']));
label = niftiread(fullfile(dir, [fileName '_seg.nii.gz']));


MergeSliceViewer({flair, t1, t1ce, t2});
