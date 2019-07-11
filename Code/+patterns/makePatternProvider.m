function patternProvider = makePatternProvider(Settings)

[~, ~, ext] = fileparts(Settings.FirstImagePath);

switch ext
    case '.h5'
        patternProvider =...
            patterns.H5PatternProvider(Settings.FirstImagePath);
    case {'.up1', '.up2'}
        patternProvider =...
            patterns.UPPatternProvider(Settings.FirstImagePath);
    case { '.jpg', '.jpeg', '.tif', '.tiff', '.bmp', '.png'}
        X = Settings.XData;
        Y = Settings.YData;
        if strcmp(Settings.ScanType,'Square')
            xStep = X(2)-X(1);
            if length(Y) > 1
                yStep = Y(2)-Y(1);
            else
                yStep = 0; %Line Scans
            end
        else
            xStep = X(3)-X(1);
            yStep = Y(3)-Y(1);
        end
        patternProvider =...
            patterns.ImagepatternProvider(...
            Settings.FirstImagePath,...
            Settings.ScanType,...
            Settings.ScanLength,...
            [Settings.Nx, Settings.Ny],...
            [Settings.XData, Settings.YData],...
            [xStep, yStep]);
end
end

