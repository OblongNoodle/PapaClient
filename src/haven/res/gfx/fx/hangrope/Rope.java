package haven.res.gfx.fx.hangrope;

import haven.BGL;
import haven.Coord3f;
import haven.FColor;
import haven.FRendered;
import haven.FastMesh;
import haven.GOut;
import haven.Gob;
import haven.Light;
import haven.MapMesh;
import haven.MapView;
import haven.Material;
import haven.OCache;
import haven.RenderList;
import haven.Rendered;
import haven.States;
import haven.glsl.BaseColor;

import javax.media.opengl.GL2;
import java.awt.Color;
import java.util.ArrayList;
import java.util.List;

@haven.FromResource(name = "gfx/fx/hangrope", version = 3, override = true)
public class Rope implements FRendered, MapView.Clickable {
//    public static final Layout fmt = new Layout(new Layout.Input(Homo3D.vertex, new VectorFormat(3, NumberFormat.FLOAT32), 0, 0, 24),
//            new Layout.Input(Homo3D.normal, new VectorFormat(3, NumberFormat.FLOAT32), 0, 12, 24));
    public final Coord3f off;
    public final float z1;
    public final float z2;
    public final float d;
//    public final Model model;
//    public final Collection<Slot> slots = new ArrayList<>(1);

    public Rope(Coord3f off, float z1, float z2) {
        off = Coord3f.of(off.x, -off.y, off.z);
        this.off = off;
        this.z1 = z1;
        this.z2 = z2;
        this.d = (float) Math.hypot(off.x, off.y);
//        this.model = mkmodel();
    }

    /*public Model mkmodel() {
        var n = Math.max(1 + Math.round(d / 3), 3);
        var buf = new VertexBuilder(fmt);
        buf.set(1, 0, 0, 1);
        for (int i = 0; i < n; i++) {
            var a = (float) i / (float) (n - 1);
            buf.set(0, getc(a));
            buf.emit();
        }
        return (new Model(Model.Mode.LINE_STRIP, buf.finv(), null));
    }*/

    public Coord3f getc(float a) {
        return (Coord3f.of(off.x * a, off.y * a, ((off.z + z2 - z1) * a) + z1 - ((float) Math.cos((a - 0.5) * Math.PI) * d * 0.1f)));
    }

    /*@Override
    public void draw(Pipe st, Render g) {
        g.draw(st, model);
    }*/

    /*@Override
    public void added(Slot slot) {slots.add(slot);}*/

    /*@Override
    public void removed(Slot slot) {slots.remove(slot);}*/

    @Override
    public boolean setup(final RenderList r) {
        return (true);
    }

    @Override
    public void draw(final GOut g) {
        int n = Math.max(1 + Math.round(d / 3), 3);
        List<Coord3f> cc = new ArrayList<>();
        for (int i = 0; i < n; i++) {
            float a = (float) i / (float) (n - 1);
            Coord3f c = getc(a);
            cc.add(c);
        }
        BGL gl = g.gl;
        g.st.put(Light.lighting, null);
        g.state(new States.ColState(new Color(0.3f, 0.2f, 0.15f)));
        g.apply();
        gl.glLineWidth(3f);
        gl.glBegin(GL2.GL_LINE_STRIP);
        for (int i = 0; i < cc.size() - 1; i++) {
            Coord3f c1 = cc.get(i);
            Coord3f c2 = cc.get(i == cc.size() - 1 ? 0 : (i + 1));
            gl.glVertex3f(c1.x, c1.y, c1.z);
            gl.glVertex3f(c2.x, c2.y, c2.z);
        }
        gl.glEnd();
    }

    @Override
    public void drawflat(final GOut g) {
        draw(g);
    }

    @Override
    public Object[] clickargs(MapView.ClickInfo cd) {
        /*Object[] ret = {0, (int) gob.id, gob.rc.floor(OCache.posres), 0, -1};
        for (Rendered node : cd.array()) {
            if (node instanceof Gob.Overlay) {
                ret[0] = 1;
                ret[3] = ((Gob.Overlay) node).id;
            }
        }*/
        return (new Object[0]);
    }
}
