package haven.res.gfx.fx.hangrope;

import haven.GLState;
import haven.GOut;
import haven.Gob;
import haven.Loading;
import haven.Location;
import haven.MapView;
import haven.Message;
import haven.MessageBuf;
import haven.OCache;
import haven.RenderList;
import haven.Rendered;
import haven.Resource;
import haven.Skeleton;
import haven.Sprite;
import haven.States;

import java.awt.Color;
import java.util.ArrayList;
import java.util.Collection;

@haven.FromResource(name = "gfx/fx/hangrope", version = 3, override = true)
public class HangingRope extends Sprite implements MapView.Clickable {
    public static final GLState ropemat = GLState.compose(Location.goback("gobx"), Rendered.postpfx/*, new States.LineWidth(UI.scale(3))*/,
            new States.ColState(new Color(0.3f, 0.2f, 0.15f)));
    public final long end;
    public final Collection<Sprite> hanging;
    private final Gob gob;
    private Rope rope = null;
    private Hanging hangc = null;
//    private final Collection<Slot> slots = new ArrayList<>(1);

    public HangingRope(Owner owner, Resource res, long end, Collection<Sprite> hanging) {
        super(owner, res);
        this.gob = (owner instanceof Gob) ? (Gob) owner : owner.context(Gob.class);
        mainClick = new RopeClick(gob, -1);
        this.end = end;
        this.hanging = hanging;
    }

    public static HangingRope mksprite(Owner owner, Resource res, Message sdt) {
        long end = sdt.uint32();
        ArrayList<Sprite> hanging = new ArrayList<Sprite>();
        while (!sdt.eom()) {
            Resource hres = owner.context(Resource.Resolver.class).getres(sdt.uint16()).get();
            Message hdt = new MessageBuf(sdt.bytes(sdt.uint8()));
            hanging.add(Sprite.create(owner, hres, hdt));
        }
        hanging.trimToSize();
        return (new HangingRope(owner, res, end, hanging));
    }

    public class Hanging implements Rendered {
//        public final Collection<Slot> slots = new ArrayList<>(1);
        public final Rendered[] parts;

        public Hanging() {
            Collection<Rendered> posd = new ArrayList<>();
            int i = 0, n = hanging.size();
            for (Sprite h : hanging) {
                posd.add(GLState.compose(Location.xlate(rope.getc((float) (i + 1) / (float) (n + 1))),
                                h.res.flayer(Skeleton.BoneOffset.class, "h").from(null)/*,
                                new RopeClick(gob, i)*/)
                        .apply(h));
                i++;
            }
            parts = posd.toArray(new Rendered[0]);
        }

        /*@Override
        public void added(Slot slot) {
            slot.ostate(Location.goback("gobx"));
            for (var part : parts)
                slot.add(part);
            slots.add(slot);
        }*/

        /*@Override
        public void removed(Slot slot) {
            slots.remove(slot);
        }*/

        @Override
        public boolean setup(final RenderList r) {
            r.prepo(Location.goback("gobx"));
            for (Rendered part : parts)
                r.add(part, null);
            for (int i = 0; i < parts.length; i++)
                r.add(new RopeClick(gob, i), null);
            return (true);
        }

        @Override
        public void draw(final GOut g) {}
    }

    private Gob curend = null;

    @Override
    public boolean tick(double dt) {
        Gob end = gob.glob.oc.getgob(this.end);
        if (end != curend) {
            if (rope != null) {
                /*while (!rope.slots.isEmpty())
                    Utils.el(rope.slots).remove();*/
                rope = null;
            }
            if (hangc != null) {
                /*while (!hangc.slots.isEmpty())
                    Utils.el(hangc.slots).remove();*/
                hangc = null;
            }
            curend = end;
        }
        if ((end != null) && (rope == null)) {
            try {
                Rope rope = new Rope(end.getc().sub(gob.getc()), 25, 25);
//                ropemat.apply(rope);
                this.rope = rope;
            } catch (Loading l) {
            }
        }
        if ((rope != null) && (hangc == null)) {
            Hanging hangc = new Hanging();
            try {
//                RUtils.multiadd(slots, hangc);
                this.hangc = hangc;
            } catch (Loading l) {
            }
        }
        for (Sprite h : hanging)
            h.tick(dt);
        return (false);
    }

    /*@Override
    public void added(Slot slot) {
        slot.ostate(new RopeClick(gob, -1));
        if (rope != null)
            slot.add(ropemat.apply(rope.model, false));
        if (hangc != null)
            slot.add(hangc);
        slots.add(slot);
    }*/

    /*@Override
    public void removed(Slot slot) {
        slots.remove(slot);
    }*/

    RopeClick mainClick;

    @Override
    public boolean setup(final RenderList d) {
        d.add(new RopeClick(gob, -1), null);
        if (rope != null) {
//            d.add(ropemat.apply(rope.model), null);
//            d.add(ropemat.apply(rope), null);
            d.add(rope, ropemat);
        }
        if (hangc != null)
            d.add(hangc, null);
        return (true);
    }

    @Override
    public Object[] clickargs(MapView.ClickInfo cd) {
        Object[] ret = {0, (int) gob.id, gob.rc.floor(OCache.posres), 0, -1};
        for (Rendered node : cd.array()) {
            if (node instanceof Gob.Overlay) {
                ret[0] = 1;
                ret[3] = ((Gob.Overlay) node).id;
            }
        }
        return (ret);
    }
}
