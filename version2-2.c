void bresenham_optimized(int xx1, int yy1, int xx2, int yy2)
{
	int iterations;
    int deltaX = abs(xx2 - xx1);
    int deltaY = abs(yy2 - yy1);
    int stepx = (xx1 < xx2) ? 1 : -1;
    int stepy = (yy1 < yy2) ? 1 : -1;
    int fraction;
    int steps = (deltaX > deltaY) ? deltaX : deltaY;

    if (deltaX > deltaY)//deltaX larger
    {
        fraction = deltaY - (deltaX >> 1);// >>1 == divide by 2 = right shift 1 place
        for (iterations = 0; iterations <= steps; iterations++)
        {
            /* buffer_plotX = xx1;
            buffer_plotY = yy1;
            buffer_plot();*/

            if (fraction >= 0)
            {
                yy1 += stepy;
                fraction -= deltaX;
            }
            xx1 += stepx;
            fraction += deltaY;
        }
    }
    else        //deltaY larger or equal
    {
        fraction = deltaX - (deltaY >> 1);// >>1 == divide by 2 = right shift 1 place
        for (iterations = 0; iterations <= steps; iterations++)
        {
            /* buffer_plotX = xx1;
            buffer_plotY = yy1;
            buffer_plot();*/

            if (fraction >= 0)
            {
                xx1 += stepx;
                fraction -= deltaY;
            }
            yy1 += stepy;
            fraction += deltaX;
        }
    }
}
