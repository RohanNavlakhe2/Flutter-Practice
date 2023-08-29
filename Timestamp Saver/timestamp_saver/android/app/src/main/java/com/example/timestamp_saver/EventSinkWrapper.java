package com.example.timestamp_saver;

import android.os.Parcel;
import android.os.Parcelable;

import java.io.Serializable;

import io.flutter.plugin.common.EventChannel;

public class EventSinkWrapper implements Parcelable {
    EventChannel.EventSink events;

    EventSinkWrapper(EventChannel.EventSink events)
    {
        this.events =events;
    }

    protected EventSinkWrapper(Parcel in) {
        events = (EventChannel.EventSink) in.readValue(EventChannel.EventSink.class.getClassLoader());

    }

    public static final Creator<EventSinkWrapper> CREATOR = new Creator<EventSinkWrapper>() {
        @Override
        public EventSinkWrapper createFromParcel(Parcel in) {
            return new EventSinkWrapper(in);
        }

        @Override
        public EventSinkWrapper[] newArray(int size) {
            return new EventSinkWrapper[size];
        }
    };

    @Override
    public int describeContents() {
        return 0;
    }

    @Override
    public void writeToParcel(Parcel parcel, int i) {
        parcel.writeValue(events);
    }
}
