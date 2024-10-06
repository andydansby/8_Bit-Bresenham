void bresenham(int line_x1, int line_y1, int line_x2, int line_y2)
{
    /// idea behind this is that theres only a finite number of pixels
    /// which should be a the MAX between delta_x1 or delta_y1
    ///

    int stepX;
    int stepY;
    int deltaX;
    int deltaY;
    int fraction;
    int steps;
    int iterations = 0;

    deltaX = Math.Abs(line_x2 - line_x1);       //deltaX = Math.Abs(delta_x1);
    deltaY = Math.Abs(line_y2 - line_y1);       //deltaY = Math.Abs(delta_y1);

    stepX = (line_x1 < line_x2) ? 1 : -1;
    stepY = (line_y1 < line_y2) ? 1 : -1;

    //steps = (deltaX > deltaY) ? deltaX : deltaY;
    if (deltaX > deltaY)
        steps = deltaX;
    else
        steps = deltaY;

    steps = Max(deltaX, deltaY);

    //plot starting point
    //buffer_plotX = line_x1;
    //buffer_plotY = line_y1;
    //buffer_plot();

    if (deltaX > deltaY)
    {
        fraction = deltaY - (deltaX >> 1);
        //fraction = deltaY - (deltaX / 2);

        for (iterations = 0; iterations <= steps; iterations++)
        {
            //buffer_plotX = line_x1;
            //buffer_plotY = line_y1;
            //buffer_plot();
            //buffer_point();

            if (fraction >= 0)
            {
                line_y1 += stepY;
                fraction -= deltaX;
            }
            line_x1 += stepX;
            fraction += deltaY;
        }//end for loop
    }//end if

    else       //(deltaX <= deltaY)     (deltaY >= deltaX)
    {
        fraction = deltaX - (deltaY >> 1);
        //fraction = deltaX - (deltaY / 2);

        for (iterations = 0; iterations <= steps; iterations++)
        {
            //buffer_plotX = line_x1;
            //buffer_plotY = line_y1;
            //buffer_plot();
            //buffer_point();

            if (fraction >= 0)
            {
                fraction -= deltaY;
                line_x1 += stepX;
            }
            line_y1 += stepY;
            fraction += deltaX;

        }//end for loop
    }//end else
}
