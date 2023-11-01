uniform float uTime;
uniform float uSize;

attribute float aScale;
attribute vec3 aRandomness;

varying vec3 vColor;

void main() {
 
 vec4 modelPosition = modelMatrix * vec4(position, 1.0);

 // Spin
 float angle = atan(modelPosition.x, modelPosition.z);
 float distanceToCentre = length(modelPosition.xz);
 float offsetAngle = (1.0 / distanceToCentre * uTime * 0.17);
 angle += offsetAngle;
 modelPosition.x = cos(angle) * distanceToCentre;
 modelPosition.z = sin(angle) * distanceToCentre;

 // Randomness
 modelPosition.xyz += aRandomness;

 vec4 viewPosition = viewMatrix * modelPosition;
 vec4 projectionPosition = projectionMatrix * viewPosition;

 gl_Position = projectionPosition;
 gl_PointSize = uSize * aScale;
 gl_PointSize *= (1.0 / - viewPosition.z); // size attenuation formula

 vColor = color;
}