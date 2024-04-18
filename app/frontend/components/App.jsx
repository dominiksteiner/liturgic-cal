import React, {useState, useEffect} from 'react';
import { LocalizationProvider } from '@mui/x-date-pickers/LocalizationProvider';
import { AdapterDayjs } from '@mui/x-date-pickers/AdapterDayjs';
import { DateCalendar } from '@mui/x-date-pickers/DateCalendar';

const App = () => {
    const [media, setMedia] = useState([]);
    const [date, setDate] = useState();

    useEffect(() => {
        if (date) {
            fetch(`/api/v1/medias?day=${date.date()}&month=${date.month()+1}&year=${date.year()}`)
            .then((res) => res.json())
            .then((data) => setMedia(data));
        }
      }, [date]);

    const onDateChange = (date) => {
        setDate(date)
    }


    return (
        <div>
            <LocalizationProvider dateAdapter={AdapterDayjs}>
                <DateCalendar onChange={onDateChange} />
            </LocalizationProvider>
            {media.map((medium) => <div><a target="_blank" href={medium.url}>{medium.title}</a></div>)}
        </div>
    );
};

export default App;