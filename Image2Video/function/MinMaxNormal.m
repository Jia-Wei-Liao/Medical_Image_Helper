function [newImg] = MinMaxNormal(image)
m = min(image, [], 'all');
M = max(image, [], 'all');
newImg = (image - m) / (M-m);

end