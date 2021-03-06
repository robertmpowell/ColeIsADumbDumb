using Toybox.Application    as App;
using Toybox.Communications as Comm;
using Toybox.WatchUi        as Ui;
using Toybox.System         as Sys;
using Toybox.Graphics       as Gfx;

var queueSize = 7;
var queue = [0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0];

var phoneMethod;
var page = 1;
var validData = false;

class OBD2_HackISU_ConnectIQApp extends App.AppBase {

    function initialize()
    {
        AppBase.initialize();

        phoneMethod = method(:onPhone);
        Comm.registerForPhoneAppMessages(phoneMethod);
    }

    // onStart() is called on application start up
    function onStart(state)
    {
    }

    // onStop() is called when your application is exiting
    function onStop(state)
    {
    }

    // Return the initial view of your application here
    function getInitialView()
    {
        return [new OBD2_HackISU_ConnectIQView01(), new BaseInputDelegate()];
    }

    function onPhone(msg)
    {
        queue = msg.data;

        validData = true;



//        if(0.0 != queue[6])
//        {
			/*Apple.playTone(TONE_CANARY);
            if(true == System.getDeviceSettings().vibrateOn())
            {
                vibeData =
                    [
                        new Attention.VibeProfile(100, 500), // On for two seconds
                        new Attention.VibeProfile(0, 500)  // Off for two seconds
                    ];
                Attention.vibrate(vibeData);
            }

			//Apple.backlight(true);*/
 //       }


        Ui.requestUpdate();
    }
}

class ViewHelper
{
    function drawGauge(dc, maxValue, currentValue, isLeftSide, arcColor, tickColor)
    {
        dc.setColor(tickColor, Gfx.COLOR_TRANSPARENT);

        var arcLength = 90.0 - ( (currentValue / maxValue) * 90.0 );

        if(true == isLeftSide)
        {
            dc.drawArc(218/2, 218/2, 107, Gfx.ARC_CLOCKWISE, 225, 135);
            dc.drawLine(33, 33, 30, 30);
            dc.drawLine(33, 185, 30, 188);

            dc.setColor(arcColor, Gfx.COLOR_TRANSPARENT);
            // 225 -> 135
            if( 0.0 != currentValue )
            {
                dc.drawArc(218/2, 218/2, 109, Gfx.ARC_CLOCKWISE, 225, 135 + arcLength);
                dc.drawArc(218/2, 218/2, 108, Gfx.ARC_CLOCKWISE, 225, 135 + arcLength);
                dc.drawArc(218/2, 218/2, 107, Gfx.ARC_CLOCKWISE, 225, 135 + arcLength);
                dc.drawArc(218/2, 218/2, 106, Gfx.ARC_CLOCKWISE, 225, 135 + arcLength);
                dc.drawArc(218/2, 218/2, 105, Gfx.ARC_CLOCKWISE, 225, 135 + arcLength);
                dc.drawArc(218/2, 218/2, 104, Gfx.ARC_CLOCKWISE, 225, 135 + arcLength);
                dc.drawArc(218/2, 218/2, 103, Gfx.ARC_CLOCKWISE, 225, 135 + arcLength);
            }
        }
        else
        {
            dc.drawArc(218/2, 218/2, 107, Gfx.ARC_COUNTER_CLOCKWISE, 315, 45);
            dc.drawLine(185, 33, 188, 30);
            dc.drawLine(185, 185, 190, 190);

            dc.setColor(arcColor, Gfx.COLOR_TRANSPARENT);
            // 315 -> 45
            if( 0.0 != currentValue)
            {
                dc.drawArc(218/2, 218/2, 109, Gfx.ARC_COUNTER_CLOCKWISE, 315, 45 - arcLength);
                dc.drawArc(218/2, 218/2, 108, Gfx.ARC_COUNTER_CLOCKWISE, 315, 45 - arcLength);
                dc.drawArc(218/2, 218/2, 107, Gfx.ARC_COUNTER_CLOCKWISE, 315, 45 - arcLength);
                dc.drawArc(218/2, 218/2, 106, Gfx.ARC_COUNTER_CLOCKWISE, 315, 45 - arcLength);
                dc.drawArc(218/2, 218/2, 105, Gfx.ARC_COUNTER_CLOCKWISE, 315, 45 - arcLength);
                dc.drawArc(218/2, 218/2, 104, Gfx.ARC_COUNTER_CLOCKWISE, 315, 45 - arcLength);
                dc.drawArc(218/2, 218/2, 103, Gfx.ARC_COUNTER_CLOCKWISE, 315, 45 - arcLength);
            }
            dc.setColor(tickColor, Gfx.COLOR_TRANSPARENT);
        }
    }
}