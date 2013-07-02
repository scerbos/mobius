package peasy;

import java.awt.MouseInfo;
import java.awt.Point;

import processing.core.PApplet;

public class EdgeMonitor {
	int left, right, top, bottom, xpos, ypos, ydelta, xdelta;
	Point mouse;
	final PeasyCam cam;
	final PApplet p;
	boolean online;

	/*
	 * Draw registration is needed as the MouseEvent for mouseChange does
	 * not detect mouse movement after the mouse leaves the frame space. We
	 * need to watch the outside of the frame to determine if the mouse goes
	 * beyond this area.
	 */

	EdgeMonitor(final PApplet p, final PeasyCam cam) {
		this.p = p;
		this.cam = cam;
		 try {
			 p.getAppletContext();
			 online = true;
		} catch (NullPointerException e) {
			 online = false;
		}
		cam.setMouseOverSketch(true);
		p.registerMethod("draw", this);
	}

	void cancel() {
		p.unregisterMethod("draw", this);
	}

	public void draw() {

		if (!online) {
			/*
			 * Only run if the frame has focus or is not visible (FullScreen
			 * library)
			 */
			if (p.frame.isFocused() || !p.frame.isVisible()) {

				this.mouse = MouseInfo.getPointerInfo().getLocation();

				if (p.frame.isVisible()) {
					this.xpos = p.frame.getBounds().x;
					this.ypos = p.frame.getBounds().y;
					if (p.frame.isUndecorated()) {
						this.ydelta = (p.frame.getBounds().height - p.height) / 2;
						this.xdelta = (p.frame.getBounds().width - p.width) / 2;
					} else {
						this.ydelta = p.frame.getBounds().height - p.height;
						this.xdelta = p.frame.getBounds().width - p.width;
					}
				} else {
					this.xpos = 0;
					this.ypos = 0;
					this.ydelta = 0;
					this.xdelta = 0;
				}

				this.left = this.xpos + this.xdelta;
				this.top = this.ypos + this.ydelta;
				this.right = this.left + p.width - 1;
				this.bottom = this.top + p.height - 1;

				if (mouse.x <= this.left || mouse.x >= this.right
						|| mouse.y <= this.top || mouse.y >= this.bottom) {

					double dx = 0;
					double dy = 0;

					if (mouse.x <= this.left) {
						dx = -8;
					} else if (mouse.x >= this.right) {
						dx = 8;
					}
					if (mouse.y <= this.top) {
						dy = -8;
					} else if (mouse.y >= this.bottom) {
						dy = 8;
					}

					cam.getPanDragHandler().handleDrag(dx, dy);
				}
			}
		} else {
			if (!cam.isMouseOverSketch()) {

				double dx = 0;
				double dy = 0;

				/*
				 * Runs only if in applet and the mouse is off-screen.
				 * mouseExit is more accurate than p.mouseX and p.mouseY for
				 * the screen edge - attempt to determine exit location
				 */

				if (cam.getMouseExit().x <= 1) {
					dx = -8;
				} else if (cam.getMouseExit().x >= p.width - 1) {
					dx = 8;
				}
				if (cam.getMouseExit().y <= 1) {
					dy = -8;
				} else if (cam.getMouseExit().y >= p.height - 1) {
					dy = 8;
				}

				cam.getPanDragHandler().handleDrag(dx, dy);
			}
		}
	}
}