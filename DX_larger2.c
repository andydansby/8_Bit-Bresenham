if (deltaX > deltaY)    //deltaX and deltaY are 16 bits and also positive only
{
    fraction = deltaY - (deltaX >> 1);
    //fraction = deltaY - (deltaX / 2);

    for (iterations = 0; iterations <= steps; iterations++)
    {
        //buffer_plotX = line_x1;
        //buffer_plotY = line_y1;
        //buffer_plot();
        //buffer_point();

        if (fraction >= 0)  //fraction is 16 bits and can be negative
        {
            fraction -= deltaX;
            line_y1 += stepY;
        }
        line_x1 += stepX;
        fraction += deltaY;
    }//end for loop
}//end if
