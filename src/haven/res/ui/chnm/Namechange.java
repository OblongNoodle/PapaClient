package haven.res.ui.chnm;

import haven.CheckBox;
import haven.Coord;
import haven.FromResource;
import haven.HRuler;
import haven.Label;
import haven.TextEntry;
import haven.UI;
import haven.Utils;
import haven.Widget;
import haven.Window;

import java.util.ArrayList;
import java.util.List;

@FromResource(name = "ui/chnm", version = 3, override = true)
public class Namechange extends Window {
    public final TextEntry nm;
    public final List<CheckBox> cnts = new ArrayList<>();
    public final List<CheckBox> srvs = new ArrayList<>();
    private Widget cntprev, srvprev;

    public Namechange(String curnm) {
        super(Coord.z, "Change Name", true);
        Widget prev = add(new Label("What is your name, traveler?"), Coord.z);
        nm = add(new TextEntry(UI.scale(200), curnm) {
            @Override
            public void activate(String text) {
                Namechange.this.wdgmsg("nm", text);
            }
        }, prev.pos("bl").adds(0, 10));
        pack();
    }

    public static Widget mkwidget(UI ui, Object[] args) {
        return (new Namechange((String) args[0]));
    }

    @Override
    public void uimsg(String msg, Object... args) {
        if (msg == "cnt") {
            String cnm = (String) args[0];
            Object id = args[1];
            boolean sel = Utils.bv(args[2]);
            if (cntprev == null) {
                Widget prev = (srvprev == null) ? nm : srvprev;
                cntprev = add(new HRuler(UI.scale(200)), prev.pos("bl").adds(0, 10).x(0));
                cntprev = add(new Label("Select a continent to start on:"), cntprev.pos("bl").adds(0, 5));
            }
            CheckBox ck = add(new CheckBox(cnm), cntprev.pos("bl").adds(0, 2).xs(5));
            ck.a = sel;
            ck.click(() -> {
                for (CheckBox cnt : cnts)
                    cnt.set(cnt == ck);
                wdgmsg("cnt", id);
            });
            cnts.add(ck);
            cntprev = ck;
            pack();
        } else if (msg == "srv") {
            String snm = (String) args[0];
            Object id = args[1];
            boolean sel = Utils.bv(args[2]);
            int uc = Utils.iv(args[3]);
            double load = Utils.dv(args[4]);
            String lbl = String.format("%s (%,d %s, %d%% load)", snm,
                    uc, (uc == 1) ? "player" : "players", Math.round(load * 100));
            if (srvprev == null) {
                Widget prev = (cntprev == null) ? nm : cntprev;
                srvprev = add(new HRuler(UI.scale(200)), prev.pos("bl").adds(0, 10).x(0));
                srvprev = add(new Label("Select a server to play on:"), srvprev.pos("bl").adds(0, 5));
            }
            CheckBox ck = add(new CheckBox(lbl), srvprev.pos("bl").adds(0, 2).xs(5));
            ck.a = sel;
            ck.click(() -> {
                for (CheckBox srv : srvs)
                    srv.set(srv == ck);
                wdgmsg("srv", id);
            });
            srvs.add(ck);
            srvprev = ck;
            pack();
        } else {
            super.uimsg(msg, args);
        }
    }
}
