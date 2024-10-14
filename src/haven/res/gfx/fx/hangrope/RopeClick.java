package haven.res.gfx.fx.hangrope;

import haven.GOut;
import haven.Gob;
import haven.MapView;
import haven.OCache;
import haven.RenderList;
import haven.Rendered;

@haven.FromResource(name = "gfx/fx/hangrope", version = 3, override = true)
public class RopeClick implements MapView.Clickable, Rendered {
    public final Gob gob;
    public final int part;

    public RopeClick(Gob gob, int part) {
        this.gob = gob;
        this.part = part;
    }

    @Override
    public Object[] clickargs(MapView.ClickInfo cd) {
        Object[] ret = {0, (int) gob.id, gob.rc.floor(OCache.posres), 0, part};
        for (Rendered node : cd.array()) {
            if (node instanceof Gob.Overlay) {
                ret[0] = 1;
                ret[3] = ((Gob.Overlay) node).id;
            }
        }
        return (ret);
    }

    @Override
    public String toString() {
        return (String.format("#<gob-click %d %s>", gob.id, gob.getres()));
    }

    @Override
    public boolean setup(final RenderList r) {
        return (false);
    }

    @Override
    public void draw(final GOut g) {}
}
