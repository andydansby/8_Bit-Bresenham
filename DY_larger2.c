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
