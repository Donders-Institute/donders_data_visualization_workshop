function [h_figure, p, settings] = setup_figure(layers, settings)
%
%
%
%



% Desired figure width
figure_width = settings.figure.width;
figure_margin = settings.figure.margin;
panel_margin = settings.panel.margin;

% Map panel settings
map_area_margin = settings.panel.map.margin;

slice_width_constraints = settings.panel.map.slice_width_constraints;
slice_height_constraints = settings.panel.map.slice_height_constraints;
yxratio_slice = settings.panel.map.slice.yx_ratio;
n_slice = settings.panel.map.n_slice;

% Plot panel settings
plot_area_margin = settings.panel.plot.margin;

plot_width_constraints = settings.panel.plot.plot_width_constraints;
plot_height_constraints = settings.panel.plot.plot_height_constraints;
yxratio_plot = settings.panel.plot.yx_ratio;

plot_n_panel = 3; % Number of coordinates for scatter plots

%  Compute number of color bars, if any
n_color_bar = 0;
for i_layer = 1:numel(layers)
    if ~isempty(layers(i_layer).color.label())
        n_color_bar = n_color_bar + 1;
    end
end

map_n_panel = n_slice + n_color_bar;

settings.panel.map.n_color_bar = n_color_bar;
settings.panel.map.n_panel = map_n_panel;

% Map area - compute number of rows and colums + area width and height
% =========================================================================
% Make map area as square as possible, provided that slice constraints are
% met

map_area_width = figure_width - ...
                 figure_margin(1) - figure_margin(3) - ...
                 panel_margin(1) - panel_margin(3) - ...
                 map_area_margin(1) - map_area_margin(3);

map_n_column = ceil(sqrt(map_n_panel/yxratio_slice));

slice_width = map_area_width / map_n_column;

% If not within constraints, set to min or max width
if all(slice_width >= slice_width_constraints(1) & ...
       slice_width <= slice_width_constraints(2))
elseif slice_width < slice_width_constraints(1)
    slice_width = slice_width_constraints(1);
    map_n_column = floor(map_area_width / slice_width);    
elseif slice_width > slice_width_constraints(2)
    slice_width = slice_width_constraints(2);
    map_n_column = ceil(map_area_width / slice_width);
end

map_n_row = ceil(map_n_panel / map_n_column);
map_area_height = map_area_width / map_n_column * yxratio_slice * map_n_row + map_area_margin(2) + map_area_margin(4);

% Put variables in settings struct
settings.panel.map.area_width = map_area_width;
settings.panel.map.area_height = map_area_height;
settings.panel.map.n_row = map_n_row;
settings.panel.map.n_column = map_n_column;

% Plot area - compute number of rows and colums + area width and height
% =========================================================================
% Make plot area as square as possible, provided that plot constraints are
% met

plot_area_width = figure_width - ...
                  figure_margin(1) - figure_margin(3) - ...
                  panel_margin(1) - panel_margin(3) - ...
                  plot_area_margin(1) - plot_area_margin(3);


% Plot panel settings
% ----

plot_n_column = ceil(sqrt(plot_n_panel/yxratio_plot));
plot_width = plot_area_width / plot_n_column;

% If not within constraints, set to min or max width
if all(plot_width >= plot_width_constraints(1) & ...
       plot_width <= plot_width_constraints(2))
elseif plot_width < plot_width_constraints(1)
    plot_width = plot_width_constraints(1);
    plot_n_column = floor(plot_area_width / plot_width);
elseif plot_width > plot_width_constraints(2)
    plot_width = plot_width_constraints(2);
    plot_n_column = ceil(plot_area_width / plot_width);
end

plot_n_row = ceil(plot_n_panel / plot_n_column);
plot_area_height = plot_area_width / plot_n_column * yxratio_plot * plot_n_row + plot_area_margin(2) + plot_area_margin(4);

% Put variables in settings struct
settings.panel.plot.area_width = plot_area_width;
settings.panel.plot.area_height = plot_area_height;
settings.panel.plot.n_row = plot_n_row;
settings.panel.plot.n_column = plot_n_column;

% Compute map area height to plot area height ratio
% =========================================================================

settings.panel.height_proportion.map    = map_area_height / (map_area_height + plot_area_height);
settings.panel.height_proportion.plot   = plot_area_height / (map_area_height + plot_area_height);


figure_height = map_area_height + plot_area_height + ...
                2 * (panel_margin(2) + panel_margin(4)) + ...
                figure_margin(2) + figure_margin(4);

settings.figure.height = figure_height;

% Setup figure
% =========================================================================

% N.B. http://undocumentedmatlab.com/blog/graphic-sizing-in-matlab-r2015b
% http://nl.mathworks.com/matlabcentral/fileexchange/60953-scaled-figure-class

% Make new figure
h_figure = figure;
settings.figure.handle = h_figure;

% Get screen size
screen_size = get(0,'ScreenSize');

figure_width_pix = figure_width .* unitsratio('inches','mm') .* get(0,'ScreenPixelsPerInch');
figure_height_pix = figure_height .* unitsratio('inches','mm') .* get(0,'ScreenPixelsPerInch');

if figure_width_pix > screen_size(3) | figure_height_pix > screen_size(4)
   screen_wh_ratio = screen_size(3:4);
   pos = get(hFig,'Position');
   pos(3:4) = min(screen_wh_ratio ./ [figure_width,figure_height]) .* [figure_width,figure_height];
   set(hFig,'Position',[pos(3)/2,pos(4)/2,pos(3),pos(4)])
else
   left_pos = screen_size(3)/2 - figure_width_pix/2;
   bottom_pos = screen_size(4)/2 - figure_height_pix/2;
   set(settings.figure.handle,'Position',[left_pos,bottom_pos,figure_width_pix,figure_height_pix])
end

% Center figure on paper
set(settings.figure.handle, 'PaperType', settings.paper.type);
set(settings.figure.handle, 'PaperUnits', 'centimeters');

switch lower(settings.paper.orientation)
   case 'landscape'
      orient landscape
   case 'portrait'
      orient portrait
   otherwise
      orient portrait
end

% Paper settings
paper_dim = get(settings.figure.handle,'PaperSize');
paper_width = paper_dim(1);
paper_height = paper_dim(2);
x_left = (paper_width-figure_width/10)/2; 
y_top = (paper_height-figure_height/10)/2;
set(settings.figure.handle,'PaperPosition',[x_left y_top figure_width/10 figure_height/10])


% Setup panels
% =========================================================================

figure(h_figure);
p = panel();
p.margin = settings.figure.margin;
p.pack('v',[settings.panel.height_proportion.map, ...
            settings.panel.height_proportion.plot]);
p(1).margin = settings.panel.margin;
p(2).margin = settings.panel.margin;
p(1).pack(settings.panel.map.n_row, ...
          settings.panel.map.n_column);
p(2).pack(settings.panel.plot.n_row, ...
          settings.panel.plot.n_column);
p(1).children.margin = settings.panel.map.margin;
p(2).children.margin = settings.panel.map.margin;

