x += xvel;
y += yvel;

xvel *= 0.9;
yvel *= 0.9;

if (lifespan > 0)
{
	lifespan --;
	
	if (lifespan < 50)
	{
		image_alpha = lifespan/50
	}
}
else
{
	instance_destroy(id);
}