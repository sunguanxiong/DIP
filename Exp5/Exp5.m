function Exp5
%检测角点大致剪裁出纸张位置大小
im = rgb2gray(imread('sample.jpg'));
im = medfilt2(im,[2,2]);
im_new = rectcrop(im);
%图像锐化
%分块做二值化，因为整体的灰度差异可能很小，分局部处理会提升效果。
[m,n] = size(im_new);
half1 = im_new(1:m/3,:);
half2 = im_new(m/3+1:2*m/3,:);
half3 = im_new(2*m/3+1:m-200,:);
half4 = im_new(m-200:m-50,:);
B1 = OSTU(half1);
B2 = OSTU(half2);
B3 = OSTU(half3);
B4 = OSTU(half4);
%合并二值化的图像
im_new = cat(1,B1,B2,B3,B4);
imshow(im_new);


%噪声处理，(去掉不连通的点)图像平滑（先膨胀后腐蚀）
im = filter2([1,1,1;1,1,1;1,1,1],im_new);
figure;
imshow(im>7);

%按行对图像分割

[m,n] = size(im_new);
% for i=1:m
%     if sum(im_new(i,:))>
%     end
% end

%按列对行分割


%统计字符数。
end
function im_new = rectcrop(im)
    points = detectHarrisFeatures(im);
    location = points.Location;
    num = size(location,1);
%     summ = sum(location,2);
%     pmin = find(summ == min(summ));
%     pmax = find(summ == max(summ));
    Lcorner = [location(1,:);location(2,:)];
    Rcorner = [location(num-1,:);location(num,:)];
    X = [Lcorner(:,1);Rcorner(:,1)];
    Y = [Lcorner(:,2);Rcorner(:,2)];
    X = sort(X);
    Y = sort(Y);
    im_new = imcrop(im,[X(2)+10 Y(2)+10 X(3)-X(2)-10 Y(3)-Y(2)-10]);
end