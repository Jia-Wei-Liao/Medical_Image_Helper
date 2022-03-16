function WriteVideo(image, videoName)

v = VideoWriter([videoName]);
[~, ~, nz, ~] = size(image);

open(v);

for i= 1:nz
    slice = squeeze(image(:, :, i, :));
    writeVideo(v, slice);
end

close(v);

end
