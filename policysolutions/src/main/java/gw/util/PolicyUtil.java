package gw.util;

import gw.gtapi.util.Utilities;
import org.joda.time.format.DateTimeFormatter;
import org.joda.time.format.ISODateTimeFormat;

import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.*;

public class PolicyUtil {
    private static final DateTimeFormatter dtf = ISODateTimeFormat.date();
    private static final SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd");
    private static final String UNRESTRICTED_USER = "su";
    private static final int PERSONAL_AUTO_RENEWAL_LEAD_TIME = 45;

    public static String getRandomName(String prefix){
        return  prefix + (Utilities.getSecureRandom().nextInt( Integer.MAX_VALUE ) + 1);
    }

    public static String addMonthsToISODateString(String dateStr, int numMonths) throws ParseException {
        Date date = dtf.parseDateTime(dateStr).toDate();
        Calendar cal = Calendar.getInstance();
        cal.setTime(date);
        cal.add(Calendar.MONTH, numMonths);
        return sdf.format(cal.getTime());
    }

    public static String addDaysToISODateString(String dateStr, int numDays) throws ParseException {
        Date date = dtf.parseDateTime(dateStr).toDate();
        Calendar cal = Calendar.getInstance();
        cal.setTime(date);
        cal.add(Calendar.DATE, numDays);
        return sdf.format(cal.getTime());
    }

    public static String currentISODateString() throws ParseException {
        Date date = new Date();
        Calendar cal = Calendar.getInstance();
        cal.setTime(date);
        return sdf.format(cal.getTime());
    }

    public static Map<String, String> getDefaultCredentials() {
        Map<String, String> defaultCredentials = new HashMap<>();
        defaultCredentials.put("username", "su");
        defaultCredentials.put("password", "gw");
        return defaultCredentials;
    }

    public static String getUnrestrictedUser() {
        return UNRESTRICTED_USER;
    }

    public static int getPersonalAutoRenewalLeadTime() { return PERSONAL_AUTO_RENEWAL_LEAD_TIME; }
}
