package com.drawonapp.animationchallenge

import android.os.Bundle
import androidx.activity.ComponentActivity
import androidx.activity.compose.setContent
import androidx.compose.animation.core.*
import androidx.compose.foundation.Canvas
import androidx.compose.foundation.layout.*
import androidx.compose.runtime.Composable
import androidx.compose.runtime.getValue
import androidx.compose.ui.Alignment
import androidx.compose.ui.Modifier
import androidx.compose.ui.draw.alpha
import androidx.compose.ui.graphics.Path
import androidx.compose.ui.tooling.preview.Preview
import androidx.compose.ui.unit.dp
import com.drawonapp.animationchallenge.ui.theme.Orange
import com.drawonapp.animationchallenge.ui.theme.Yellow
import com.drawonapp.animationchallenge.ui.theme.YellowLight


/*** Solution revolves around drawing the shapes using canvas methods
 *  and then animating the shapes by altering dimension values of shapes ***/

class MainActivity : ComponentActivity() {
    override fun onCreate(savedInstanceState: Bundle?) {
        super.onCreate(savedInstanceState)
        setContent {
            /*** Animation is executed here ***/
            Animation()
        }
    }
}

@Composable
fun Animation() {

    var scale_transition_anim = scaleShapeTransition(initialValue = -40f, targetValue = 0f, durationMillis = 1500)

    var scale_transition_anim1 = scaleShapeTransition(initialValue = 40f, targetValue = 0f, durationMillis = 1500)

    var movement_transition_anim1 = movementTransition(initialValue = 10f, targetValue = 100f, durationMillis = 1500)

    var flame_disappearing_transition_anim = visiblityTransition(initialValue = 1f, targetValue = 0f, durationMillis = 2000)

    Column(modifier = Modifier.
    fillMaxSize(),
        horizontalAlignment = Alignment.CenterHorizontally,
        verticalArrangement = Arrangement.Center){
        
        Box() {

            /** Following line of code draws the triangle with light yellow color that you see in back ***/

            Canvas(
                modifier = Modifier
                    .width(150.dp)
                    .height(150.dp)
            ) {

                /** Triangle is basically a geometrical shape enclosed
                 * in a path having 3 vertices which starts from points mentioned in moveTo() method
                 * then the path goes to the point in
                 * first lineTo() and then ends at point in the last lineTo() **/

                /** While creating an animation we have to vary second and third vertex
                 *  so scale_transition_anim1 variable is used to produce the float values at a constant rate***/

                /** Following set of code is used for drawing triangle **/


                val path = Path().apply {
                    moveTo(0.0f, (size.height))
                    lineTo(size.width/2, 70-scale_transition_anim1)
                    lineTo(size.width-40,(size.height/2)-scale_transition_anim1)
                    close()
                }

                drawPath(path = path, color = YellowLight)

            }

            /** Following code is used for creating flame motion animation by
             * varying alpha from 1 to 0 at constant rate of 2000 ms and the
             * motion of object is done by
             * movement_transition_anim1 variable which is basically changing values of y offset
             * of the shape which causes upward motion of the flame block and then it disappears using alpha set to 0 **/

            Canvas(
                modifier = Modifier
                    .width(30.dp)
                    .height(30.dp)
                    .offset(87.dp, 30.dp-movement_transition_anim1.dp).
                     alpha(flame_disappearing_transition_anim)
            ) {

                /** Following code draws semicircle from start to end angle ***/


                drawArc(
                    color = YellowLight,
                    startAngle = 0f,
                    sweepAngle = 180f,
                    useCenter = true
                )

                val path = Path().apply {
                    moveTo(0.0f, (size.height/2))
                    lineTo((size.width/2), scale_transition_anim)
                    lineTo(size.width,(size.height/2))
                    close()
                }

                drawPath(path = path, color = YellowLight)

            }

            /** Following code is used for drawing the semicircle and triangle shape with the Orange color
             * and to animate motion the
             *  second vertex of triangle scale_transition_anim variable is used **/

            Canvas(
                modifier = Modifier
                    .size(size = 300.dp)
            ) {



                drawArc(
                    color = Orange,
                    startAngle = 0f,
                    sweepAngle = 180f,
                    useCenter = true
                )

                val path = Path().apply {
                    moveTo(0.0f, (size.height/2))
                    lineTo((size.width/2), scale_transition_anim)
                    lineTo(size.width,(size.height/2))
                    close()
                }

                drawPath(path = path, color = Orange)

            }

            /** Following code is used for drawing the semicircle and triangle shape with yellow color and to animate motion the
             *  second vertex of triangle scale_transition_anim variable is used **/

            Canvas(
                modifier = Modifier
                    .size(size = 150.dp)
                    .align(Alignment.Center)
            ){


                drawArc(
                    color = Yellow,
                    startAngle = 0f,
                    sweepAngle = 180f,
                    useCenter = true
                )

                val path = Path().apply {
                    moveTo(0.0f, (size.height/2))
                    lineTo((size.width/2), scale_transition_anim)
                    lineTo(size.width,(size.height/2))
                    close()
                }

                drawPath(path = path, color = Yellow)


            }
            
        }

    }
}

@Preview(showBackground = true)
@Composable
fun DefaultPreview() {
    Animation()
}


@Composable
fun scaleShapeTransition(
    initialValue: Float,
    targetValue: Float,
    durationMillis: Int
): Float {
    val infiniteTransition = rememberInfiniteTransition()
    val scale: Float by infiniteTransition.animateFloat(
        initialValue = initialValue,
        targetValue = targetValue,
        animationSpec = infiniteRepeatable(
            animation = tween(durationMillis, easing = LinearEasing),
            repeatMode = RepeatMode.Restart
        )
    )

    return scale
}

@Composable
fun movementTransition(
    initialValue: Float,
    targetValue: Float,
    durationMillis: Int
): Float {
    val infiniteTransition = rememberInfiniteTransition()
    val scale: Float by infiniteTransition.animateFloat(
        initialValue = initialValue,
        targetValue = targetValue,
        animationSpec = infiniteRepeatable(
            animation = tween(durationMillis, easing = LinearEasing),
        )
    )

    return scale
}

@Composable
fun visiblityTransition(
    initialValue: Float,
    targetValue: Float,
    durationMillis: Int
): Float {
    val infiniteTransition = rememberInfiniteTransition()
    val scale: Float by infiniteTransition.animateFloat(
        initialValue = initialValue,
        targetValue = targetValue,
        animationSpec = infiniteRepeatable(
            animation = tween(durationMillis),
        )
    )

    return scale
}