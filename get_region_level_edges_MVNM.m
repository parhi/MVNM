function [adj_regions_train, adj_regions_val]=get_region_level_edges_MVNM(adj_train,adj_val,TargetElectrodes)
% converts a channel level network into a region-level network using MVNM
% inputs
% adj_train -- a 3D channel-level adjacenecy matrix of causal networks of size DxDxN where D is the number of channels/nodes and N is the number of  networks
% adj_val -- is a validation set of networks that use the training set's PCA coeffciceints to apply MVNM
% TargetElectrodes -- region information a cell array where entry is an array with channel indices that belong to the same region
% number of cells/rows in TargetElectrodes is the number of regions 
% outputs
% adj_region_train -- regoin level networks training data
% adj_region_val -- region level networks validation data
% Sandeep Avvaru avvar002@umn.edu

numregions = size(TargetElectrodes,1);
adj_regions_train=zeros(numregions,numregions,size(adj_train,3));
adj_regions_val=zeros(numregions,numregions,size(adj_val,3));
region_pairs=nchoosek(1:numregions,2);
for i=1:size(region_pairs,1)
    row=region_pairs(i,1);
    col=region_pairs(i,2);
    
    regX=TargetElectrodes(row,2);
    regY=TargetElectrodes(col,2);
    
    % X to Y
    x2y_edges = adj_train(regX{1,1},regY{1,1},:);
    x2y_reshaped=reshape(x2y_edges,size(x2y_edges,1)*size(x2y_edges,2), size(x2y_edges,3));
    [coeff,score,~,~,~,mu] = pca(x2y_reshaped');
    x2y_new=score(:,1);
    adj_regions_train(row,col,:)=x2y_new;
    
    x2y_edges_val=adj_val(regX{1,1},regY{1,1},:);
    x2y_reshaped_val=reshape(x2y_edges_val,size(x2y_edges_val,1)*size(x2y_edges_val,2), size(x2y_edges_val,3));
    x2y_val_new_temp=(x2y_reshaped_val'-mu)*coeff;
    x2y_val_new=x2y_val_new_temp(:,1);
    adj_regions_val(row,col,:)=x2y_val_new;
    
    y2x_edges = adj_train(regY{1,1},regX{1,1},:); 
    y2x_reshaped=reshape(y2x_edges,size(y2x_edges,1)*size(y2x_edges,2), size(y2x_edges,3));
    [coeff,score,~,~,~,mu] = pca(y2x_reshaped');
    y2x_new=score(:,1);
    adj_regions_train(col,row,:)=y2x_new;
    
    y2x_edges_val=adj_val(regY{1,1},regX{1,1},:);
    y2x_reshaped_val=reshape(y2x_edges_val,size(y2x_edges_val,1)*size(y2x_edges_val,2), size(y2x_edges_val,3));
    y2x_val_new_temp=(y2x_reshaped_val'-mu)*coeff;
    y2x_val_new=y2x_val_new_temp(:,1);
    adj_regions_val(col,row,:)=y2x_val_new;
end
