package org.papervision3d.objects.special {
	import org.papervision3d.core.geom.renderables.Particle;
	import org.papervision3d.materials.special.ParticleMaterial;
	import org.papervision3d.objects.special.ParticleField;		

	/**
	 * @author Trevor
	 */
	public class StarSphere extends ParticleField 
	{
		private var radius:Number;
		
		public function StarSphere(mat : ParticleMaterial, quantity : int = 200, radius:Number = 1000, particleSize : Number = 10) 
		{
			super(mat, quantity, NaN, NaN, NaN, particleSize);
			
			this.radius = radius;
		}
		
		override protected function createParticles():void
		{
			for( var i:Number = 0; i < quantity; i++ )
			{
				addParticle(new Particle(material as ParticleMaterial, (Math.random() * particleSize) + 1, Math.random()*radius, Math.random()*radius, Math.random()*radius));	
			}
		}
	}
}
