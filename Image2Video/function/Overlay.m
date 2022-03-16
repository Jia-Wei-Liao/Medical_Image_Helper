function [outImg] = Overlay(downImg, upImg, colorMap, alpha)
mask = downImg;
nonZero = AddRGBChannel(upImg ~= 0);
imgSize = size(downImg);
colorMask = zeros(imgSize);
colorMask(:, :, :, 1) = colorMap(1);
colorMask(:, :, :, 2) = colorMap(2);
colorMask(:, :, :, 3) = colorMap(3);
colorMask =  colorMask .* nonZero;
mask(nonZero) = colorMask(nonZero);
outImg = alpha*mask + (1-alpha)*downImg;

end