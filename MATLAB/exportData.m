function exportData(meas,name)
    data = meas.Data;
    data(isnan(data(:,1)),:) = [];
    dlmwrite(name,data,'delimiter','\t','newline', 'pc');
end