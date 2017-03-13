----------------------------------------------------------------------------------------------------------------------------------------------------------------
Questions                                                                       Examples/Suggestions
------------------------------------------------------------------------------- --------------------------------------------------------------------------------
__1. Design__

1.1. Is the visualization consistent with the hypothesis being tested?          - If data have been residualized or transformed for statistical analysis they
                                                                                  should also be transformed in the graph.
                                                                                - If data are paired between conditions, the graph should reveal the pairwise differences rather than differences at the group level.

1.2. Are there any "empty dimensions" that could be removed?                    - e.g. 3D bar/pie chart of 2D data
                                                                                - e.g. colors that encode no meaningful information

1.3. Does the display provide an honest and transparent visualization of the    - hiding, smoothing, or modifying data has been avoided
data?                                                                           - actual data are emphasized over idealized models

__2. Axes__

2.1. Are axes scales defined as linear, log, or radial?

2.2. Does each axis label describe the variable and its units?

2.3. Are axis limits appropriate for the data?

2.4. Is the aspect ratio appropriate for the data?                              - e.g. when x and y plot the same variable under different conditions, the axes
                                                                                  should be square

2.5. Are the axes intuitive?

__3. Uncertainty__

3.1. Does the visualization depict uncertainty where necessary?

3.2. Is the type of uncertainty appropriate for the data?                       - If the interest is estimating a population parameter, then the variation of
                                                                                  the estimate (i.e., the sampling distribution of the statistic) is wanted, as
                                                                                  given by e.g. SEM or 95% CI.

                                                                                - If the interest is possible observational outcomes, then the variation of the
                                                                                  data is desired, as reflected in e.g. SD and interquartile range.

3.3. Are the units of uncertainty labeled?                                      - e.g. "error bars indiciate standard errors of the mean"                        

__4. Color__

4.1. Is color necessary or useful?

4.2. Can features be discriminated when printed in grayscale?                   - e.g. by using symbols _and_ colors to discriminate groups/condition

4.3. Does the visualization accomodate common forms of colorblindness?          - e.g. you can simulate color blindness with the colorblindness simulator      
                                                                                  [Coblis](http://www.color-blindness.com/coblis-color-blindness-simulator/)

__5. Color mapping__

5.1. Is the color map consistent with the data type                             - e.g. use a sequential map for unipolar data (in/decrease from origin/0)

                                                                                - e.g. use a diverging map for bipolar data (diverge from origin/0)

                                                                                - e.g. use a circular map for circular data (e.g. time of day, week, year, etc.)

__6. Annotation__

6.1. Are all symbols defined?

6.2. Is the directionality of a contrast between conditions obvious?            - e.g. "Patients - Controls" rather than "Patients vs. Controls"

6.3. Is the number of samples indicated?

6.4. Are statistical procedures and criteria for significance described?

6.5. Are uncommon abbreviations avoided or clearly defined?

----------------------------------------------------------------------------------------------------------------------------------------------------------------
Checklist based on [Allen et al., Neuron, 2012](https://dx.doi.org/10.1016/j.neuron.2012.05.001)

Table: Checklist for evaluating scientific figures
