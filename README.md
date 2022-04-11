# MVNM
Maximal Variance Node Merging

 converts a channel level network into a region-level network using MVNM

inputs

adj_train -- a 3D channel-level adjacenecy matrix of causal networks of size DxDxN where D is the number of channels/nodes and N is the number of  networks

adj_val -- is a validation set of networks that use the training set's PCA coeffciceints to apply MVNM

TargetElectrodes -- region information a cell array where each entry is an array with channel indices that belong to the same region

number of cells/rows in TargetElectrodes is the number of regions 

outputs

adj_region_train -- region level networks training data

adj_region_val -- region level networks validation data


Cite:

Sandeep Avvaru, Noam Peled, Nicole R. Provenza, Alik S. Widge, and Keshab K. Parhi. Region-level functional and effective network analysis of human brain during cognitive task engagement. IEEE Transactions on Neural Systems and Rehabilitation Engineering, 29:1651–1660, 2021.
https://ieeexplore.ieee.org/document/9514845
