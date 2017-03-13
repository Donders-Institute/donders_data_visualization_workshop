%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% 1. Evaluating figures
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% 2. Anscombe's quartet
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% 3. Graphical perception
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%% 3.1. Decoding accuracy and efficiency varies with visual attribute
graphical_perception('decoding_visual_attributes')

%% 3.2. Decoding curve differences is surprisingly difficult
graphical_perception('decoding_differences')

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% 4. Visualizing low-dimensional data: simple plots
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% 5. Visualizing high-dimensional data: fMRI data
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%% 5.1. Provide access to paths

% Provide access to the paths
workshop_dir = '/Users/bramzandbelt/surfdrive/projects/donders_data_visualization_workshop/';

% Provide access to MATLAB and SPM
addpath(genpath('/Users/bramzandbelt/Documents/MATLAB/spm12/'))

% Provide access to a few toolboxes we are going to use
addpath(genpath(fullfile(workshop_dir,'opt','gramm')))
addpath(genpath(fullfile(workshop_dir,'opt','panel-2.12')))
addpath(genpath(fullfile(workshop_dir,'opt','slice_display')))

% Provide access to the code written for this workshop
addpath(genpath(('/Users/bramzandbelt/surfdrive/projects/donders_data_visualization_workshop/src/code/workshop_fmri/')))

%% 5.2. FMRI - preliminaries

% Point to the directories containing the data ...
workshop_dir    = '/Users/bramzandbelt/surfdrive/projects/donders_data_visualization_workshop/';
data_dir        = fullfile(workshop_dir,'data','workshop_fmri');
glm_dir         = fullfile(workshop_dir,'data','workshop_fmri','fmri','stat_stop_left_vs_stop_both');
roi_dir         = fullfile(data_dir,'fmri','region_of_interest_masks');

% Load color maps
colormaps_file  = fullfile(workshop_dir,'data','workshop_fmri','fmri','colormaps.mat');
load(colormaps_file);

%% 5.3. FMRI vis 01 - common design (thresholded t-map)

% Initialize empty layers and settings variables
layers                      = sd_config_layers('init',{'truecolor','blob'});
settings                    = sd_config_settings('init');
    
% Specify layers
layers(1).color.file        = fullfile(spm('Dir'),'canonical','single_subj_T1.nii');
layers(1).color.map         = gray(256);

layers(2).color.file        = fullfile(glm_dir,'spmT_0001.nii');
layers(2).color.map         = CyBuBkRdYl;
layers(2).color.label       = 't-value';
layers(2).mask.file         = fullfile(glm_dir,'stop_left_vs_stop_both_significant_voxels_FWE_voxel_level.nii');

% Specify settings
settings.slice.orientation  = 'axial';
settings.slice.disp_slices  = -16:8:72;
settings.fig_specs.n.slice_column = 4;
settings.fig_specs.title    = 'stop_{left} - stop_{both}';

% Display the t-map overlaid on the anatomical MRI
sd_display(layers,settings);

%% 5.4. FMRI vis 02 - dual-coding design

% Initialize empty layers and settings variables
layers                      = sd_config_layers('init',{'truecolor','dual','contour'});
settings                    = sd_config_settings('init');
    
% Specify layers
layers(1).color.file        = fullfile(spm('Dir'),'canonical','single_subj_T1.nii');
layers(1).color.map         = gray(256);

layers(2).color.file        = fullfile(glm_dir,'con_0001.nii');
layers(2).color.map         = CyBuGyRdYl;
layers(2).color.label       = '\beta_{Stop_{left}} - \beta_{Stop_{both}} (a.u.)';
layers(2).opacity.file      = fullfile(glm_dir,'spmT_0001.nii');
layers(2).opacity.label     = '| t |';
layers(2).opacity.range     = [0 5.17];

layers(3).color.file        = fullfile(glm_dir,'stop_left_vs_stop_both_significant_voxels_FWE_voxel_level.nii');

% Specify settings
settings.slice.orientation  = 'axial';
settings.slice.disp_slices  = -16:8:72;
settings.fig_specs.n.slice_column = 4;
settings.fig_specs.title    = 'stop_{left} - stop_{both}';

% Display the t-map overlaid on the anatomical MRI
sd_display(layers,settings);

%% 5.5. FMRI vis 03 - dual-coding design w/ group mean T1, mask, and scatter

% Initialize empty layers and settings variables
layers                      = sd_config_layers('init',{'truecolor','dual','contour','contour','contour'});
settings                    = sd_config_settings('init');
    
% Specify layers
layers(1).color.file        = fullfile(data_dir,'fmri','anatomical_images','group_mean_T1.nii');
layers(1).color.map         = gray(256);

layers(2).color.file        = fullfile(glm_dir,'con_0001.nii');
layers(2).color.map         = CyBuGyRdYl;
layers(2).color.label       = '\beta_{Stop_{left}} - \beta_{Stop_{both}} (a.u.)';
layers(2).opacity.file      = fullfile(glm_dir,'spmT_0001.nii');
layers(2).opacity.label     = '| t |';
layers(2).opacity.range     = [0 5.17];

layers(3).color.file        = fullfile(glm_dir,'stop_left_vs_stop_both_significant_voxels_FWE_voxel_level.nii');
layers(4).color.file        = fullfile(glm_dir,'mask.nii');
layers(4).color.map         = [1 1 1];

layers(5).color.file        = fullfile(roi_dir,'all_rois.nii');
layers(5).color.hold        = 1;
layers(5).color.map         = [0 1 0];

% Specify settings
settings.slice.orientation  = 'axial';
settings.slice.disp_slices  = -16:8:72;
settings.fig_specs.n.slice_column = 4;
settings.fig_specs.title    = 'stop_{left} - stop_{both}';

% Display the t-map overlaid on the anatomical MRI
sd_display(layers,settings);

% Plot scatter of individual contrast estimates for stop_left and stop_both
% -------------------------------------------------------------------------

% Load the already extracted ROI data from file
load(fullfile(data_dir,'fmri','roi_data.mat'));

% Initiatlize gramm object:
% - x-axis: contrast estimate for stop_left - go
% - y-axis: contrast estimate for stop_both - go
clear g
g = gramm('x',roi_data.con_stop_left_vs_go, ...
          'y',roi_data.con_stop_both_vs_go);

% Add subplots: hemisphere varies between rows, ROI between columns
g.facet_grid(cellstr(roi_data.roiHemi),roi_data.roiFileName);

% Add scatter
g.geom_point();

% Add inset with histogram of the difference between stop_left vs. stop_both 
g.stat_cornerhist('edges',-5:1:5,'aspect',0.8);

% Add isoline (to enable comparison between stop_left and stop_both)
% conditions)
g.geom_abline('slope',1,'intercept',0,'style','k--');

% Add x=0 line (to enable comparison between stop_left and go)
g.geom_vline('xintercept',0,'style','k--');

% Add y=0 line (to enable comparison between stop_both and go)
g.geom_hline('yintercept',0,'style','k--');

% Add axis labels
g.set_names('x','stop_left - go','y','stop_both - go','column','','row','');

% Adjust axes limits to data and make axes square
axis_limits     = [-max(abs([roi_data.con_stop_both_vs_go;roi_data.con_stop_left_vs_go])), ...
                   max(abs([roi_data.con_stop_both_vs_go;roi_data.con_stop_left_vs_go]))];

g.axe_property('DataAspectRatio',[1 1 1],'XLim',axis_limits,'YLim',axis_limits);

% Make plot
figure;
g.draw();